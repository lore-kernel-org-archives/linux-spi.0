From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Re: [LINUX RFC v2 1/4] spi: add support of two chip selects & data stripe
Date: Fri, 4 Sep 2015 14:35:52 +0200
Message-ID: <E4C1DE94-773C-498F-9CD5-639FBEEE3139@sperl.org>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com> <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com> <20150903121232.GW12027@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org,
	marex-ynQEQJNshbs@public.gmane.org, b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org, knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150903121232.GW12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 03.09.2015, at 14:12, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Wed, Aug 26, 2015 at 11:56:04AM +0530, Ranjit Waghmode wrote:
>=20
>> To support dual parallel mode operation of ZynqMP GQSPI controller
>> following API's are added inside the core:
>=20
> As covered in SubmittingPatches please try to make each patch a singl=
e
> change rather than having multiple separate changes in one commit.
>=20
>> +	/* Controller may support more than one chip.
>> +	 * This flag will enable that feature.
>> +	 */
>> +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both chips */
>=20
> This isn't saying that the controller supports more than one chip, it=
's
> saying that the controller supports asserting more than one chip sele=
ct
> at once which isn't the same thing.  I'm also not entirely sure that
> this makes sense as a separate feature to the data striping one - I'm
> struggling to think of a way to use this sensibly separately to that.

Well - there is one use-case that I can think of:
fbtft has the requirement for some devices to control a GPIO to
differentiate between command and data getting transferred
- sort of 9 bit.

Right now it is done outside of spi in the fbtft driver itself wrapping
spi_sync().

Similarly a =E2=80=9Chold=E2=80=9D line on an eeprom or similar could g=
et (de)asserted
without requiring holding a spi-bus-lock.

But then the current patch would not allow this kind of =E2=80=9Cgeneri=
c=E2=80=9D
use-case.

Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
