#!/bin/bash

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-a, --all                 run the site playbook"
                        echo "-n, --onboarding          run the onboarding playbook"
                        echo "-o, --operation           run the operation playbook"
                        echo "-t, --teardown            run the teardown playbook"
                        exit 0
                        ;;
                -n)
                        shift
                        ansible-playbook playbooks/onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --onboarding*)
                        ansible-playbook playbooks/onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -o)
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --operation*)
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -t)
                        ansible-playbook playbooks/teardown.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --teardown*)
                        ansible-playbook playbooks/teardown.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --today*)
                        ansible-playbook playbooks/today.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -a)
                        ansible-playbook site.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --all*)
                        ansible-playbook site.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done
