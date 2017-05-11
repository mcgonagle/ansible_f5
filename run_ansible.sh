#!/bin/bash

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-n, --onboarding          run the onboarding playbook"
                        echo "-o, --operation           run the operation playbook"
                        echo "-t, --teardown            run the teardown playbook"
                        exit 0
                        ;;
                -n)
                        shift
                        ansible-playbook onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --onboarding*)
                        ansible-playbook onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -o)
                        ansible-playbook operations.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --operation*)
                        ansible-playbook operations.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -t)
                        ansible-playbook teardown.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                --teardown*)
                        ansible-playbook teardown.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done
