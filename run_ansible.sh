#!/bin/bash

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-a, --all                 run the all playbooks"
                        echo "-n, --onboarding          run the onboarding playbook"
                        echo "-o, --operation           run the operation playbook"
                        echo "-t, --teardown            teardown the operation playbook"
                        echo "--t-all                   teardown all playbooks"
                        echo "--itemp                   run the iApptemplate playbook"
                        echo "--ihttp                   run the http_iApp playbook"
                        echo "--iwaf                    run the https_waf_iApp playbook"
                        echo "--iscp                    run the scp_iApp playbook"
                        echo "--ha                      run the ha_onboarding playbook"
                        echo "--today                   run the today playbook"
                        exit 0
                        ;;
                -n)
                        ;&
                --onboarding)
                        ansible-playbook playbooks/onboarding.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -o)
                        ;&
                --operation)
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -e state="present" -vvv 
                        shift
                        ;;
                --itemp)
                        ansible-playbook playbooks/iAppTemplate.yml --ask-vault-pass -e @password.yml -e state="present"
                        shift
                        ;;
                --ihttp)
                        ansible-playbook playbooks/http_iApp.yml --ask-vault-pass -e @password.yml -e state="present"
                        shift
                        ;;
                --iwaf)
                        ansible-playbook playbooks/https_waf_iApp.yml --ask-vault-pass -e @password.yml -e state="present"
                        shift
                        ;;
                --iscp)
                        ansible-playbook playbooks/scp_iApp.yml --ask-vault-pass -e @password.yml -e state="present"
                        shift
                        ;;
                --ha)
                        ansible-playbook playbooks/ha_onboarding.yml --ask-vault-pass -e @password.yml -e state="present"
                        shift
                        ;;
		--t-all)
			ansible-playbook playbooks/all.yml --ask-vault-pass -e @password.yml -e state="absent"
                        shift
                        ;;
                -t)
                        ;&
                --teardown)
                        ansible-playbook playbooks/operations.yml --ask-vault-pass -e @password.yml -e state="absent" -vvv 
                        shift
                        ;;
                --today*)
                        ansible-playbook playbooks/today.yml --ask-vault-pass -e @password.yml -vvv 
                        shift
                        ;;
                -d)
                        ;&
                --date*)
                        ansible-galaxy init roles/$(date +%m%d%Y) && cd roles; ln -sfn $(date +%m%d%Y) today;cd .. 
                        shift
                        ;;
                -a)
                        ;&
                --all*)
                        ansible-playbook playbooks/all.yml --ask-vault-pass -e @password.yml -e state="present"  
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done
