#!/bin/bash

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-n, --onboarding          run the onboarding playbook"
                        echo "-o, --operation           run the operation playbook"
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
                        ansible-playbook playbooks/operation.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --operation*)
                        ansible-playbook playbooks/operation.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done
