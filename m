From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: core: add max_msg_size to spi_master
Date: Fri, 27 Nov 2015 20:26:52 +0100
Message-ID: <5658AE7C.3050507@gmail.com>
References: <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
 <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
 <20151121134946.GI26072@sirena.org.uk> <56507B3B.4080608@gmail.com>
 <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA@mail.gmail.com>
 <5650F7D4.1090209@gmail.com> <20151122131626.GN26072@sirena.org.uk>
 <5651EA08.5090400@gmail.com> <20151123113846.GH1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151123113846.GH1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 23.11.2015 um 12:38 schrieb Mark Brown:
> On Sun, Nov 22, 2015 at 05:15:04PM +0100, Heiner Kallweit wrote:
>> Am 22.11.2015 um 14:16 schrieb Mark Brown:
> 
>> To avoid misunderstandings:
>> For fsl-espi the length of a SPI transfer has to be programmed (max 64K)
>> and after this number of bytes has been transferred CS is deselected
>> internally. There's no way to control CS directly.
>> Do you consider this a message or transfer size limit?
>> To me this seems to be exactly what you describe as "devices that aren't
>> able to deal with multiple transfers independently".
> 
> Well, possibly.  What happens with a very large proportion of SPI
> controllers is that we just ignore the /CS functionality of the
> controller and use a GPIO instead, most SoC integrations also support
> GPIO on the same pin and there's rarely any advantage in trying to use
> the integrated support.
> 
Right, that's the case also for fsl-espi. The bad thing is that there's
no way to change only the CS pin to a GPIO.
Only the complete block of SPI signals can be switched to GPIO.

>>> For slightly more complex things like this it probably also makes sense
>>> to use an accessor - I can see us wanting to combine restrictions from
>>> DMA engines into restrictions for the SPI controller for example.  That
>>> gives us a bit of insulation between the clients and the API.
> 
>> When you talk about accessors do you think of hooks in spi_master so that
>> each controller driver can provide its own implementation of e.g.
>> something like get_max_msg_size()?
> 
> No, for the clients so they aren't peering at the struct.
> 
Sure, do you think of a simple getter like this or a more complex thing?

size_t spi_get_max_msg_size(struct spi_master *master)
{
	return master->max_msg_size;
}

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
