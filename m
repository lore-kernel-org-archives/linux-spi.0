From: Adrian Fiergolski <Adrian.Fiergolski-vJEk5272eHo@public.gmane.org>
Subject: Re: [PATCH] spi: Add spi-bits-per-word binding.
Date: Mon, 13 Mar 2017 19:12:13 +0100
Message-ID: <12c66ecf-8472-c108-d2b4-1d6c3a8e6e74@cern.ch>
References: <20170217101151.hyzmz5a4lgdy7p5m>
 <20170220153512.6563-1-adrian.fiergolski@cern.ch>
 <20170221190830.xyubgimyc2w5p5v6@sirena.org.uk>
 <983e943b-30f2-7d80-294a-df29bca11738@cern.ch>
 <20170313175504.mpwjxqbhc4yxk434@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <mark.rutland-5wv7dgnIgG8@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <miguel.ojeda.sandonis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170313175504.mpwjxqbhc4yxk434-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 13.03.2017 at 18:55, Mark Brown wrote:
>
>> In my case, xilinx_spi_probe function (of spi-xilinx controller) sets
>> bits_per_word_mask of spi_master struct only to 16 bits support. Later=
,
>> xilinx_spi_probe calls of_register_spi_devices, which calls
>> of_register_spi_devices. The last one allocates an empty spi_device
>> struct and configures different options of the spi_device according to=
 a
>> device tree. bits_per_word are not covered here (why?), thus it is lef=
t
>> 0 (value after allocation), which, by convention, means 8 bits support=
=2E
>> At the end, the same function (of_register_spi_device) calls
>> spi_add_device which finally calls spi_setup. The last call, according=

>> to convention, changes bits_per_word to 8 and calls
>> __spi_validate_bits_per_word which fails, as master doesn't support 8
>> bit transmission. This fails registration sequence of a device driver.=

>> As you see, the device driver doesn't have possibility to modify
>> bits_per_word during the registration process, thus it can't provide
>> support for such limited controllers.
> I can't see any way in which it follows from the above that it's a good=

> idea to try to override bits per word settings in the device tree, that=

> just wastes user time and is an abstraction failure.  We need better
> handling of defaults done purely in the kernel.
If enforcing by device tree specific for a given device driver SPI_CPHA,
SPIC_CPOL, SPI_CS_HIGH, max_speed_hz, etc. if fine form the abstraction
point of view, why it doesn't apply to bits_per_word ?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
