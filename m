From: qiaozhou <qiaozhou-XOWFcpiLszpWk0Htik3J/w@public.gmane.org>
Subject: Re: [Question] Can of_find_spi_xx_by_node be moved out of
 CONFIG_OF_DYNAMIC in SPI driver
Date: Fri, 15 Jul 2016 19:23:26 +0800
Message-ID: <5788C7AE.4050203@asrmicro.com>
References: <5786E7C0.4050709@asrmicro.com>
 <20160714101128.GK9976@sirena.org.uk> <5788446E.9080601@asrmicro.com>
 <20160715105841.GE30372@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160715105841.GE30372-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 2016=E5=B9=B407=E6=9C=8815=E6=97=A5 18:58, Mark Brown wrote:
> On Fri, Jul 15, 2016 at 10:03:26AM +0800, qiaozhou wrote:
>
>> My case is like this: I got a ARM mali-video driver, which may have =
several
>> ports/endpoints, which needs I2C/SPI interface to do some initiation=
=2E In the
>> video driver, it uses device node conf to find matching ports, and c=
alls
> This sounds like a fairly standard setup, most external HDMI encoders
> are I2C and SPI controlled, which already works fine as far as I'm aw=
are.
>
>> functions, such as of_find_video_tx_by_node -> of_find_i2c_device_by=
_node.
>> Now the hardware changes from i2c to spi, so I wonder whether
>> of_find_spi_device_by_node can be used freely. Otherwise I may need =
to
>> modify the mali-video driver, and as it's provided to us and may get=
 updated
>> from time to time, my change may be conflicted with future versions.
>> Also I didn't quite understand the way to "use a phandle to connect =
the two
>> devices", is there any code/driver which I can take as a reference? =
I'll
>> study it.
> Off the top of my head something like the TDA998x or ADV7511 should b=
e
> worth looking at here - it just sounds like the the Mali driver may j=
ust
> not be using the frameworks well, you should probably encourage peopl=
e
> to get it upstreamed.
Got it. I'll check it. Thanks a lot for the suggestions.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
