From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: core: add max_msg_size to spi_master
Date: Sun, 22 Nov 2015 17:15:04 +0100
Message-ID: <5651EA08.5090400@gmail.com>
References: <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
 <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
 <20151121134946.GI26072@sirena.org.uk> <56507B3B.4080608@gmail.com>
 <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA@mail.gmail.com>
 <5650F7D4.1090209@gmail.com> <20151122131626.GN26072@sirena.org.uk>
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
In-Reply-To: <20151122131626.GN26072-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 22.11.2015 um 14:16 schrieb Mark Brown:
> On Sun, Nov 22, 2015 at 12:01:40AM +0100, Heiner Kallweit wrote:
>> Add a member to spi_master allowing to better handle
>> SPI chips with a message size HW limit.
> 
> How many devices have an actual message size limit (as opposed to a
> transfer size limit)?  It seems like the restrictions here are really on
> transfer sizes and that we probably want a second limit for devices that
> aren't able to deal with multiple transfers independently.
> 
To avoid misunderstandings:
For fsl-espi the length of a SPI transfer has to be programmed (max 64K)
and after this number of bytes has been transferred CS is deselected
internally. There's no way to control CS directly.
Do you consider this a message or transfer size limit?
To me this seems to be exactly what you describe as "devices that aren't
able to deal with multiple transfers independently".

> For slightly more complex things like this it probably also makes sense
> to use an accessor - I can see us wanting to combine restrictions from
> DMA engines into restrictions for the SPI controller for example.  That
> gives us a bit of insulation between the clients and the API.
> 
When you talk about accessors do you think of hooks in spi_master so that
each controller driver can provide its own implementation of e.g.
something like get_max_msg_size()?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
