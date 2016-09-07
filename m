From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH] tools: spi: enable CROSS_COMPILE in Makefile
Date: Wed, 7 Sep 2016 17:24:36 +0200
Message-ID: <9eec4153-d4be-21ab-4f97-2c545c3cbbf8@linaro.org>
References: <1473258496-14565-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <ab8b24cf-0d9a-60e5-9291-d5e6e44756be@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ab8b24cf-0d9a-60e5-9291-d5e6e44756be@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 09/07/2016 05:06 PM, Daniel Thompson wrote:
> On 07/09/16 15:28, Jorge Ramirez-Ortiz wrote:
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  tools/spi/Makefile | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/spi/Makefile b/tools/spi/Makefile
>> index cd0db62..d1845b0 100644
>> --- a/tools/spi/Makefile
>> +++ b/tools/spi/Makefile
>> @@ -1,4 +1,8 @@
>> +CC = $(CROSS_COMPILE)gcc
>> +
>>  all: spidev_test spidev_fdx
>>
>> +%: %.c
>> +    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
>
> What is this extra rule for?

yes you are right. this one is not required. only setting CC. sending v2

>
> The built in rules should already honour both these variables (and 
> more besides).
>
>
> Daniel.
