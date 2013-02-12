vm.panic_on_oom:
  sysctl.present:
    - value: 1

vm.swappiness:
  sysctl.present:
    - value: 0

kernel.panic:
  sysctl.present:
    - value: 5
