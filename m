From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH v6] spi: New driver for Altera SPI
Date: Sat, 05 Feb 2011 21:08:38 +0800
Message-ID: <4D4D4BD6.3040909@wytron.com.tw>
References: <1295851114-12488-1-git-send-email-thomas@wytron.com.tw> <1296727326-2581-1-git-send-email-thomas@wytron.com.tw> <20110203173430.GC6180@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw,
	devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110203173430.GC6180@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 02/04/2011 01:34 AM, Grant Likely wrote:
> Hi Thomas, comments below, but looking pretty close.

Thanks a lot.

>> +config SPI_ALTERA
>> +	tristate "Altera SPI Controller"
>> +	select SPI_BITBANG
>
> Will this compile on all architectures?  Will it break allyesconfig
> on anything other than nios?

Yes, it compile on other architectures. I will add 'default n' though.

There are soft-core arm, mips and coldfire running on altera fpga. 
Others might use fpga as peripheral extender, too. So we shouldn't limit 
it to nios2.

>> +static int __init altera_spi_init(void)
>> +{
>> +	return platform_driver_probe(&altera_spidrv, altera_spi_probe);
>
> platform_driver_register() please, and put the altera_spi_probe()
> routine into the driver structure.

I will change it to register as you suggested.

- Thomas
