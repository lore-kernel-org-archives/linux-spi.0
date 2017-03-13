From: Adrian Fiergolski <Adrian.Fiergolski-vJEk5272eHo@public.gmane.org>
Subject: Re: [PATCH] spi: Add spi-bits-per-word binding.
Date: Mon, 13 Mar 2017 18:25:53 +0100
Message-ID: <983e943b-30f2-7d80-294a-df29bca11738@cern.ch>
References: <20170217101151.hyzmz5a4lgdy7p5m>
 <20170220153512.6563-1-adrian.fiergolski@cern.ch>
 <20170221190830.xyubgimyc2w5p5v6@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <mark.rutland-5wv7dgnIgG8@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <miguel.ojeda.sandonis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170221190830.xyubgimyc2w5p5v6-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

I think, we misunderstand. Any line of spidev (or device driver in
general) is called, if master, setting its bit_per_word_mask, doesn't
cover 8 bits per word. Thus, in such a case, any device driver has a
possibility to be registered and handle the "limited capabilities of the
controller". IMHO, the problem is in the spi core itself. I will try to
be more clear.

In my case, xilinx_spi_probe function (of spi-xilinx controller) sets
bits_per_word_mask of spi_master struct only to 16 bits support. Later,
xilinx_spi_probe calls of_register_spi_devices, which calls
of_register_spi_devices. The last one allocates an empty spi_device
struct and configures different options of the spi_device according to a
device tree. bits_per_word are not covered here (why?), thus it is left
0 (value after allocation), which, by convention, means 8 bits support.
At the end, the same function (of_register_spi_device) calls
spi_add_device which finally calls spi_setup. The last call, according
to convention, changes bits_per_word to 8 and calls
__spi_validate_bits_per_word which fails, as master doesn't support 8
bit transmission. This fails registration sequence of a device driver.
As you see, the device driver doesn't have possibility to modify
bits_per_word during the registration process, thus it can't provide
support for such limited controllers.

Regards,
Adrian


On 21.02.2017 at 20:08, Mark Brown wrote:
> On Mon, Feb 20, 2017 at 04:35:12PM +0100, Adrian Fiergolski wrote:
>> If an SPI controller doesn't support 8 bit transfers
>> (master->bits_per_word_mask), it will be never registered (tested with=

>> spidev):
>> of_register_spi_device calls spi_add_device which calls spi_setup. The=
 last
>> takes as an argument spi_device struct, which, in case of spidev, has
>> bits_per_word set to 0. Thus, the spi_setup function will set it to de=
fault
>> 8. Further, the same function will call __spi_validate_bits_per_word w=
hich
>> will fail the whole registration for controllers not supporting 8 bit
>> transfers (i.e. xilinx-spi).
> This doens't make much sense, if a device driver requires a given numbe=
r
> of bits per word forcing a different value via device tree is not going=

> to result in the driver actually working.  If you want to use a device
> with a controller with restricted bits per word support you need to
> change the device driver to support the limited capabilities of the
> controller.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
