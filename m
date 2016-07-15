From: qiaozhou <qiaozhou-XOWFcpiLszpWk0Htik3J/w@public.gmane.org>
Subject: Re: [Question] Can of_find_spi_xx_by_node be moved out of
 CONFIG_OF_DYNAMIC in SPI driver
Date: Fri, 15 Jul 2016 10:03:26 +0800
Message-ID: <5788446E.9080601@asrmicro.com>
References: <5786E7C0.4050709@asrmicro.com>
 <20160714101128.GK9976@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160714101128.GK9976-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 2016=E5=B9=B407=E6=9C=8814=E6=97=A5 18:11, Mark Brown wrote:
> On Thu, Jul 14, 2016 at 09:15:44AM +0800, qiaozhou wrote:
>> Hi Mark,
> Please don't take things off-list unless there is a really strong rea=
son
> to do so.  Sending things to the list ensures that everyone gets a
> chance to read and comment on things.
Add linux-spi-u79uwXL29TaiAVqoAR/hOA@public.gmane.org I missed it. It's indeed helpful.Thanks=20
for the tips.
>
>> I've a question about the two functions, of_find_spi_device/master_b=
y_node.
>> Can they be moved out of CONFIG_OF_DYNAMIC so that some spi device d=
river
>> can use them without CONFIG_OF_DYNAMIC defined? Some vendor provides=
 both
>> SPI and I2C interfaces, and the I2C driver has of_find_i2c_xx_by_nod=
e
>> function without OF_DYNAMIC limitation. I made a patch for SPI drive=
r, and
>> don't know whether it's appropriate. Could you help to give some com=
ments?
> Why not just use a phandle to connect the two devices?
My case is like this: I got a ARM mali-video driver, which may have=20
several ports/endpoints, which needs I2C/SPI interface to do some=20
initiation. In the video driver, it uses device node conf to find=20
matching ports, and calls functions, such as of_find_video_tx_by_node -=
>=20
of_find_i2c_device_by_node. Now the hardware changes from i2c to spi, s=
o=20
I wonder whether of_find_spi_device_by_node can be used freely.=20
Otherwise I may need to modify the mali-video driver, and as it's=20
provided to us and may get updated from time to time, my change may be=20
conflicted with future versions.
Also I didn't quite understand the way to "use a phandle to connect the=
=20
two devices", is there any code/driver which I can take as a reference?=
=20
I'll study it.
Thanks a lot for the suggestions.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
