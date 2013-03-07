def render_local(name, context, defaults={}):
    ret = {'changes': {},
           'comment': '',
           'name': name,
           'result': True}

    if __opts__['test']:
        result, comment, changes = __salt__['jinja_render.local'](name,context,defaults,True)
        ret['result'] = None
        if type(changes) is not type(None):
            if not result:
                ret['changes']['error'] = changes
            else:
                ret['changes']['diff'] = changes
        ret['comment'] = 'Testing-Mode: {0}'.format(comment)
        return ret

    result, comment, changes = __salt__['jinja_renderer.render_local'](name,context,defaults,False)
    ret['result'] = result
    ret['comment'] = comment

    # Changes will contain errors if the function failed
    if type(changes) is not type(None):
        if not result:
            ret['changes']['error'] = changes
        else:
            ret['changes']['diff'] = changes

    return ret
