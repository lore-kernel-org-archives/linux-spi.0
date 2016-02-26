From: "Huang, Tao" <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] spi/rockchip: Make sure spi clk is on in
 rockchip_spi_set_cs
Date: Fri, 26 Feb 2016 10:31:50 +0800
Message-ID: <56CFB916.5010403@rock-chips.com>
References: <1456308004-29102-1-git-send-email-huibin.hong@rock-chips.com>
 <56CD8F85.2090204@rock-chips.com> <20160226015829.GC18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"shawn.lin" <shawn.lin-NgiFYW8Wbx6Ta72+1OMJgUB+6BGkLq7r@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160226015829.GC18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2016=E5=B9=B402=E6=9C=8826=E6=97=A5 09:58, Mark Brown wrote:
>=20
>> Another way to solve this bug is add runtime PM support while spi se=
tup.
>> Some other chips may have some problem, for example mt65xx and orion=
,
>> which access hardware register too.
>=20
> No, this is telling you you're doing something wrong - setup() might =
be
> called while another transfer is in progress so you shouldn't be
> changing the hardware setup (see Documentation/spi/spi-summary).  Thi=
s
> means that you normally shouldn't be writing to registers there.  Mov=
ing
> this to prepare_message() instead is probably what you want.
>=20
You misunderstand me. I talk about spi_setup, as
Documentation/spi/spi-summary, which would normally be called from
probe() before the first I/O is done to the device.
spi_setup will call spi_set_cs(spi, false), which introduced with commi=
t
1a7b7ee72c21 ("spi: Ensure that CS line is in non-active state after
spi_setup()"). And spi_set_cs will call spi->master->set_cs, and set_cs
callback will access register. Without clk enable, I believe some
drivers will failed to run.

Best Regards,

Huang, Tao

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
