From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH] spi-fsl-dspi: Fix CTAR Register access
Date: Thu, 10 Dec 2015 10:12:25 +0530
Message-ID: <566902B1.2080503@toradex.com>
References: <1449642099-13045-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <20151209204103.GJ5727@sirena.org.uk>
Reply-To: <bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <stefan@agner.ch>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Bhuvanchandra <bhuvanchandra.dv@toradex.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209204103.GJ5727@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/10/2015 02:11 AM, Mark Brown wrote:
> On Wed, Dec 09, 2015 at 11:51:39AM +0530, Bhuvanchandra DV wrote:
>> DSPI instances in Vybrid have a different amount of chip selects
>> and CTARs (Clock and transfer Attributes Register). In case of
>> DSPI1 we only have 2 CTAR registers and 4 CS. In present driver
>
> This doesn't apply against, current code - please check and resend.

Will check and resend.

>

-- 
Best regards,
Bhuvan
