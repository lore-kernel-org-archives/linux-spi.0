From: Ken Wilson <ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCHv2 2/2] spi: orion: Add multiple chip select support to
 spi-orion
Date: Thu, 15 Jan 2015 11:07:12 +1000
Message-ID: <54B712C0.5010808@opengear.com>
References: <1421032440-15335-1-git-send-email-ken.wilson@opengear.com> <1421032440-15335-3-git-send-email-ken.wilson@opengear.com> <20150114200626.GN3043@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150114200626.GN3043-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On 15/01/15 06:06, Mark Brown wrote:
> On Mon, Jan 12, 2015 at 01:14:00PM +1000, Ken Wilson wrote:
>
>> +- num-cs     : The total number of chip selects used by this platform.
>> +		If unset, this defaults to 1.
> So, this is intended to be the number of hardware chip selects that can
> be configured but the first commit mentioned GPIOs as an option too so
> we should at least say that this is specifically the controller
> supported ones.  However...
>
>> +#define ORION_SPI_CS_MASK	0x1C
>> +#define ORION_SPI_CS_SHIFT	2
>> +#define ORION_SPI_CS(cs)	((cs << ORION_SPI_CS_SHIFT) & \
>> +					ORION_SPI_CS_MASK)
> ...given that we have a fixed bitfield here which we know and doesn't
> appear to depend on configuration do we even need this to be
> configurable - given that we're going to need an explicit node for any
> slave can't we just accept any sane chip select for a slave without
> extending the binding?
The different implementations that use this driver (Marvell Kirkwood, 
Armada 370/375) all
have a different number of supported chip selects, that fit into this 
bit mask. There are also
multiple SPI controllers on each SoC which support different numbers of 
chip selects.
For example, on the Armada 375, SPI0 supports 3 chip selects, while SPI1 
only has 1.

I agree that we could support any sane chip select for a slave, since 
the slave addresses do need
to be explicitly defined. I'm happy with whatever your preference is.

Thanks,
Ken
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
