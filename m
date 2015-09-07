From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
Date: Mon, 07 Sep 2015 10:24:41 +0300
Message-ID: <55ED3BB9.8040202@linux.intel.com>
References: <1441208649-6192-1-git-send-email-jarkko.nikula@bitmer.com> <87pp1yxais.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Axel Lin <axel.lin@ingics.com>, stable@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <87pp1yxais.fsf@belgarion.home>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 09/04/2015 10:14 PM, Robert Jarzmik wrote:
> Jarkko Nikula <jarkko.nikula@bitmer.com> writes:
>
>> From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>
>> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
>> build error here because it removed the type LPSS_SSP and I didn't notice
>> the type was used here too.
>>
>> I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
>> accidentally by copying all enum pxa_ssp_type types from
>> include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.
>>
>> Fix the build error by removing this incorrect binding.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Reported-by: Axel Lin <axel.lin@ingics.com>
>> Cc: stable@vger.kernel.org # 4.2
>> ---
>> Sorry if you got this twice today. I had email problems today and this patch
>> didn't go through to at least some of recipients. Resending from other my
>> another address.
>
> I'll take it through pxa tree, and I'll add this :
> Fixes: 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types")
>
> Up to my understanding this is the tag stable tree will use to know which kernel
> version this patch should be applied to.
>
Thanks for noticing. I added it and resent the patch as v2.

-- 
Jarkko
