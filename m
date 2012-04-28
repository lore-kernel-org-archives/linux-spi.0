From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: Device tree conversion of spi device vs. controller_data
Date: Sat, 28 Apr 2012 12:39:30 +0200
Message-ID: <4F9BC8E2.20005@antcom.de>
References: <4F816772.5000607@antcom.de> <20120413032945.0C76B3E07AC@localhost>
	<4F87D157.2020700@antcom.de> <20120427180344.F023D3E171B@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120427180344.F023D3E171B@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 27/04/12 20:03, Grant Likely wrote:
>>> Can you point me at specific code?
>>>
>>> .controller_data is owned by the spi_master driver.  The eeprom driver
>>> shouldn't be accessing it directly at all; but I'll need to look at
>>> specific code to really understand what is going on.
>>
>> Please have a look at arch/arm/mach-lpc32xx/phy3250.c :
>>
>> static struct pl022_config_chip spi0_chip_info = {
>>         .com_mode               = INTERRUPT_TRANSFER,
>>         .iface                  = SSP_INTERFACE_MOTOROLA_SPI,
>>         .hierarchy              = SSP_MASTER,
>>         .slave_tx_disable       = 0,
>>         .rx_lev_trig            = SSP_RX_4_OR_MORE_ELEM,
>>         .tx_lev_trig            = SSP_TX_4_OR_MORE_EMPTY_LOC,
>>         .ctrl_len               = SSP_BITS_8,
>>         .wait_state             = SSP_MWIRE_WAIT_ZERO,
>>         .duplex                 = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
>>         .cs_control             = phy3250_spi_cs_set,
> 
> phy3250_spi_cs_set is only a wrapper around gpio_set_value().  GPIO CS
> manipulation should be handled by the core pl022 spi driver, so that
> gets rid of the hardest part of this conversion (callbacks in platform
> data).
> 
> The pl022_config_chip structure is 100% owned by the spi controller
> (pl022).  If the bus driver depends on this structure, then it is the
> responsibility of the bus driver to allocate one and set the
> controller data pointer for each of the child devices.  You may need
> to add pl022-specific properties to each of the child nodes to
> populate this data correctly if it cannot be determined with other
> means.

Yes, that's what I'll need to do.

Thanks!

Roland

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
