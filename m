From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] spi: bcm2835aux: ensure interrupts are enabled for shared
 handler
Date: Thu, 03 May 2018 15:36:12 -0700
Message-ID: <87a7tg9xk3.fsf@anholt.net>
References: <20180503180945.3502-1-robh@kernel.org> <87efiso2yz.fsf@anholt.net>
 <CAL_Jsq+pf0y7+mV8o3t=Uvgo9ZbmVNB9PyS2E3BktR8BZ_ecQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4124982539531490523=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Ray Jui <rjui@broadcom.com>,
 Alexander Graf <agraf@suse.de>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+pf0y7+mV8o3t=Uvgo9ZbmVNB9PyS2E3BktR8BZ_ecQQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

--===============4124982539531490523==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Rob Herring <robh@kernel.org> writes:

> On Thu, May 3, 2018 at 4:15 PM, Eric Anholt <eric@anholt.net> wrote:
>> Rob Herring <robh@kernel.org> writes:
>>
>>> The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
>>> Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
>>> DT change which breaks compatibility with older kernels. The AUX irqchip
>>> was already rejected for upstream[1] and the DT change would break
>>> working systems if the DTB is updated to a newer one. The latter issue
>>> was brought to my attention by Alex Graf.
>>>
>>> The root cause however is a bug in the shared handler. Shared handlers
>>> must check that interrupts are actually enabled before servicing the
>>> interrupt. Add a check that the TXEMPTY or IDLE interrupts are enabled.
>>
>> It looks to me like we'd only return IRQ_HANDLED if we did work that
>> needed doing.  Is this check effectively doing some interlock to make
>> sure that we've already started bcm2835aux_spi_transfer_one_irq() and
>> aren't just racing against transaction setup?
>
> What if you are in polled mode for the SPI and the 8250 irq (or other
> SPI instance) causes the SPI irq handler to run?
>
> Is checking whether the interrupt is pending in the aux reg any
> different than checking for interrupt being enabled in the device? I
> could have checked the status bits too, but as you say that is handled
> farther down.

It seems clearly different to me, in that one is about allowing the
interrupt line to go high and the other is about whether the interrupt
line is actually high right now.

However, the polled mode note explains to me what was going wrong, so:

Reviewed-by: Eric Anholt <eric@anholt.net>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrrjtwACgkQtdYpNtH8
nuixgw//anOT387MPeEylNbk7NtY9WTVKVI5mGqG5HZnoP4/ScUYlPFtT8FHCsl6
js9+79aEdxDOgbJ4BMO7/qBGR8oTPv5c9nPWiO+JME9wzirDpGQV7W4/NbAUjopq
/M+sf0e1bpCrjPojob1M/kS17r33Cjvt+2zQhCSJfegwuf3HmnCvvV81jptJnglU
bZRPNhQxw66ia+anyuGBBRehQG3WOzbFaEH4yxhbh+igVfiofqm3ZsCR9CQTEje7
RJ+L5eJxCtDVYk6o89yNWXOO9/wlbdjVuoF+u0lhDzTp1P0BELweZ4WqelQrD2KH
3r33lgDlToOutW1PvsmR49ACiNWJJwzzwom3QNojgeDHpio0SJj66jsHDF4P5IpB
7C8cWudZesBFH8DKOaI/vmHbvHuIrj9xvaa9SA5DdQt05uIG2wq89tkpd8+52knT
PdvIPUsGhyfVh3UkM/zpzcg0E54YC+EyBJr/OHpBcSRJ31+ltQQJJIP/FzjdtLyj
6JbMPSzGay8eW6JdS4DLi52Te/cryzedDPooMGXjLnm4YtZQMa7ZeTUowNi+MReW
A+zvavV05K0Bx8OCbgsr8FFUueZnH9/y0SNYKCC5BS9DvF+5HdD0HslynT+WuXnU
5uzdJX6kdKDmw0IdjcYE1X4+1Pdsf2tnSHwytUFXXynPVVTJtJs=
=LPp7
-----END PGP SIGNATURE-----
--=-=-=--


--===============4124982539531490523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4124982539531490523==--
