import difflib
import jinja2
import logging
import os

from salt.exceptions import CommandExecutionError

log = logging.getLogger(__name__)

def __virtual__():
  log.debug("Loaded")
  return 'jinja_renderer'

def render_local(name, context, defaults, test=False):
    if not os.path.isfile(name):
        return False, 'No such file: {0}'.format(name), None

    defaults.update(context)
    template_string = ''.join(open(name).readlines())

    # jinja2.Template.render() strips newlines. The template will be read with a newline
    # so we store it and append it later
    newline = False
    if template_string.endswith('\n'):
        newline = True

    try:
        template = jinja2.Environment(undefined=jinja2.DebugUndefined).from_string(template_string)
        rendered_string = template.render(**context)
    except TemplateSyntaxError, exc:
        return False, 'Syntax Error in Template', 'File: {0}\nLine: {1}\nError: {2}'.format(exc.name,exc.lineno,exc.message)

    # Add newline if it was stripped
    if newline:
        rendered_string += '\n'

    if rendered_string != template_string:
        diff_template = [ '{0}\n'.format(line) for line in template_string.split('\n') ]
        diff_rendered = [ '{0}\n'.format(line) for line in rendered_string.split('\n') ]
        diff = ''.join(difflib.unified_diff(diff_template,diff_rendered))
        if not test:
            os.rename(name,'{0}.orig'.format(name))
            open(name,'w+').write(rendered_string)
            return True, 'Template rendered', diff
        else:
            return True, 'Test Mode Enabled. {0} would have been changed'.format(name), diff
    else:
        return True, 'Nothing changed when rendering {0}'.format(name), None
