From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 15/17] spi: bcm2835: Switch to SPDX identifier
Date: Tue, 13 Nov 2018 13:39:42 -0800
Message-ID: <87lg5wlkrl.fsf@anholt.net>
References: <1541868612-8268-1-git-send-email-stefan.wahren@i2se.com>
 <20181113180251.GD2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0935387344174208179=="
Cc: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20181113180251.GD2089-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============0935387344174208179==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> [ Unknown signature status ]
> On Sat, Nov 10, 2018 at 05:50:12PM +0100, Stefan Wahren wrote:
>
>> index b0b87ff..a418683 100644
>> --- a/drivers/spi/spi-bcm2835.c
>> +++ b/drivers/spi/spi-bcm2835.c
>> @@ -1,3 +1,4 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>>  /*
>>   * Driver for Broadcom BCM2835 SPI Controllers
>>   *
>
> Please convert the entire comment to a C++ one so it looks more
> intentional.

anholt@eliezer:anholt/src/linux% git grep -A1 SPDX **/*.c | grep -v SPDX | grep "/\*" | wc -l
5305
anholt@eliezer:anholt/src/linux% git grep -A1 SPDX **/*.c | grep -v SPDX | grep "//" | wc -l
683

I want to note that what you're asking for is in the minority of current
usage.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvrRJ4ACgkQtdYpNtH8
nujPIg//f/4EUitoolXYiyt6gxtqv9KsyuCwX0Q5hvcDrt5kZP4UsuQnqS6JJMu7
4hGT2fXRr5IPVyVVlXRXNTgULBMeR0BPZofgyMAgXiQvIEEYKBd6dxCMI1mXI3P5
aKc1FIUyFaCh9gv/BbLhG2IDm/eqBTGCb98LJ48Mx33F3r+t+0BZeDaQviIgST2Q
XiWmos/XYEAe5D+KUnK7XWk01vlXq/UHZL2eCtJZIJs/aIXTr2EyAi0qjfZtR3Gy
vTHGsz64CeMc47SegLv8SFhpaoT8/pM8DYvn/4hWhe9ApFwuWFr7C82NMGWk5bmJ
2cWrif0b6a7A8dHr4VTXqsCvYNP4tGPXpaYaSILh9qMVG6DloUIddQm55xdTeoi3
0/r7u9YjEtTCraJO6vK5S9RLBAHdEAnHfWSFuXkw5TWtA1ejLmrCjzDm7KVcca+k
m1sngiH9qgscyFDPG35D45TxW926i5fZ10GaU7Z/zVvOBpEUCSNumrqgpYQ4rtfR
Z0KzKpRjZiddXP77ZSmmMsdPqPWA6jXjlkYvPI9N/O/LELEj74hKPQ6Ha3TExHzp
ta0RGoL1I1jetBB5b8UkQ+TZG/JLY9VF578WTHRULlN9jDlr4EXcxTsfJHKCpa6h
DMuAM0WotvrkwWYfEiHLr09v/ERzvnF+WrtQnGh9AW/YRkwp9kM=
=kPX1
-----END PGP SIGNATURE-----
--=-=-=--


--===============0935387344174208179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============0935387344174208179==--
