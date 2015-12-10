From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] spi-fsl-dspi: Fix CTAR Register access
Date: Thu, 10 Dec 2015 14:14:11 +0530
Message-ID: <56693B5B.6060100@toradex.com>
References: <1449726930-7378-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <2295258.Vc5Dp4nsCT@ws-stein>
Reply-To: <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <stefan-XLVq0VzYD2Y@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2295258.Vc5Dp4nsCT@ws-stein>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/10/2015 12:45 PM, Alexander Stein wrote:
> On Thursday 10 December 2015 11:25:30, Bhuvanchandra DV wrote:
>> DSPI instances in Vybrid have a different amount of chip selects
>> and CTARs (Clock and transfer Attributes Register). In case of
>> DSPI1 we only have 2 CTAR registers and 4 CS. In present driver
>> implementation CTAR offset is derived from CS instance which will
>> lead to out of bound access if chip select instance is greater than
>> CTAR register instance, hence use single CTAR0 register for all CS
>> instances. Since we write the CTAR register anyway before each access,
>> there is no value in using the additional CTAR registers. Also one
>> should not program a value in CTAS for a CTAR register that is not
>> present, hence configure CTAS to use CTAR0.
>
> Shouldn't the information put into struct fsl_dspi_devtype_data how much CTAR and CS the actual implementation has available? E.g. LS1021A has 6 CS and 4 CTAR

I guess still this will not help us when CS instance greater than CTAR 
instance is selected. Other point to consider here is we are writing the 
CTAR register before every access, so for us there is no additional 
advantage of using multiple CTAR registers.

>
> Best regards,
> Alexander
>

-- 
Best regards,
Bhuvan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
