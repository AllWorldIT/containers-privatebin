#!/bin/bash
# Copyright (c) 2022-2023, AllWorldIT.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.



fdc_test_start privatebin "Check PrivateBin is responding using IPv4..."
if ! curl --verbose --ipv4 "$NGINX_HEALTHCHECK_URI" --output test.out; then
	fdc_test_fail privatebin "Failed to get test data from PrivateBin using IPv4"
	false
fi

if ! grep -q "<title>PrivateBin</title>" test.out; then
	fdc_test_fail privatebin "Contents of output from PrivateBin does not contain a title using IPv4"
	false
fi
fdc_test_pass privatebin "PrivateBin is responding using IPv4"


fdc_test_start privatebin "Check PrivateBin is responding to termbin pastes using IPv4..."
if ! echo "TEST SUCCESS" | curl --verbose --ipv4 "http://localhost" --output test.out -d @-; then
	fdc_test_fail privatebin "Failed to get test data from PrivateBin using IPv4"
	false
fi
if ! grep "Paste Link" test.out | awk '{print $3}' | grep -q http://localhost/; then
	fdc_test_fail privatebin "Contents of output from PrivateBin does not contain a paste link using IPv4"
	false
fi
fdc_test_pass privatebin "PrivateBin is responding to termbin pastes using IPv4"



# Return if we don't have IPv6 support
if [ -z "$(ip -6 route show default)" ]; then
	fdc_test_alert privatebin "Not running IPv6 tests due to no IPv6 default route"
	return
fi


# We need to wait 10s to prevent rate limiting
sleep 15


fdc_test_start privatebin "Check PrivateBin is responding using IPv6..."
if ! curl --verbose --ipv6 "$NGINX_HEALTHCHECK_URI" --output test.out; then
	fdc_test_fail privatebin "Failed to get test data from PrivateBin using IPv6"
	false
fi

if ! grep -q "<title>PrivateBin</title>" test.out; then
	fdc_test_fail privatebin "Contents of output from PrivateBin does not contain a title using IPv6"
	false
fi
fdc_test_pass privatebin "PrivateBin is responding using IPv6"


fdc_test_start privatebin "Check PrivateBin is responding to termbin pastes using IPv6..."
if ! echo "TEST SUCCESS" | curl --verbose --ipv6 "http://localhost" --output test.out -d @-; then
	fdc_test_fail privatebin "Failed to get test data from PrivateBin using IPv6"
	false
fi
if ! grep "Paste Link" test.out | awk '{print $3}' | grep -q http://localhost/; then
	fdc_test_fail privatebin "Contents of output from PrivateBin does not contain a paste link using IPv6"
	cat test.out
	false
fi
fdc_test_pass privatebin "PrivateBin is responding to termbin pastes using IPv6"
