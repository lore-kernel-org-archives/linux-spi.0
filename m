From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Mon, 25 Sep 2017 10:19:56 -0700
Message-ID: <449abd0e-8d8b-86e9-2b7a-65c27ab3171b@infradead.org>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
 <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
 <20170925161221.v23dpeljin5kakhz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170925161221.v23dpeljin5kakhz@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 09/25/17 09:12, Mark Brown wrote:
> On Fri, Sep 22, 2017 at 06:46:46PM -0700, Randy Dunlap wrote:
>> On 09/22/17 02:26, Mark Brown wrote:
> 
>>> right thing - if we can use hwspinlocks in a module when they're enabled
>>> I'd expect to be able to build the stubs that way too.
> 
>> Sorry, I'm not understanding what you are trying to say on that one.
> 
>> HWSPINLOCK	SPI_SPRD_ADI
> 
>> but this combo is not allowed (with the patch) or causes build errors
>> (without the patch):
>> 	m		y
> 
> Why is that not just an || COMPILE_TEST dependency then?  The dependency
> you're trying to introduce is weird and confusing, we shouldn't be
> having to do things like that.

It already uses COMPILE_TEST:

config SPI_SPRD_ADI
	tristate "Spreadtrum ADI controller"
	depends on ARCH_SPRD || COMPILE_TEST
	help
	  ADI driver based on SPI for Spreadtrum SoCs.

but that allows build errors when SPI_SPRD_ADI=y and HWSPINLOCK=y.

As for the dependency that I am adding:
+	depends on HWSPINLOCK || HWSPINLOCK=n

that idiom is used over and over again in Kconfig files to prevent this kind of
build problem in loadable modules.


-- 
~Randy
