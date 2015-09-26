From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ARM: pxa: Remove unused clock_enable field from struct pxa2xx_spi_master
Date: Sat, 26 Sep 2015 21:47:53 +0200
Message-ID: <87io6xezdi.fsf@belgarion.home>
References: <1442560481-26008-1-git-send-email-jarkko.nikula@linux.intel.com>
	<87k2rlq9go.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <philipp.zabel@gmail.com>,
	Paul Parsons <lost.distance@yahoo.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k2rlq9go.fsf@belgarion.home> (Robert Jarzmik's message of
	"Sun, 20 Sep 2015 19:36:23 +0200")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:
>
>> Use for struct pxa2xx_spi_master clock_enable field was removed years ago
>> from the pxa2xx-spi driver by the commit 2f1a74e5a2de ("[ARM] pxa: make
>> pxa2xx_spi driver use ssp_request()/ssp_free()").
>>
>> Therefore remove it from structure definition, documentation and from
>> couple affected board files.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> ---
>> I propose this to be merged via ARM tree. I don't see we would need to do
>> other SPI related changes to struct pxa2xx_spi_master in near future (knock
>> on wood).
> I'll take that through the pxa/for-next tree in a couple of days, thanks.
Queued in pxa/for-next, thanks.

Cheers.

-- 
Robert
