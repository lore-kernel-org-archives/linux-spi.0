From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2] spi: bcm2835aux: ensure interrupts are enabled for
 shared handler
Date: Wed, 30 May 2018 12:11:07 -0700
Message-ID: <87sh69nelw.fsf@anholt.net>
References: <20180523205220.7394-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3168259045591088498=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Alexander Graf <agraf@suse.de>,
 linux-spi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, Martin
 Sperl <kernel@martin.sperl.org>, Noralf =?utf-8?Q?Tr=C3=B8nnes?=
 <noralf@tronnes.org>, Phil Elwell <phil@raspberrypi.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180523205220.7394-1-robh@kernel.org>
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

--===============3168259045591088498==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Rob Herring <robh@kernel.org> writes:

> The BCM2835 AUX SPI has a shared interrupt line (with AUX UART).
> Downstream fixes this with an AUX irqchip to demux the IRQ sources and a
> DT change which breaks compatibility with older kernels. The AUX irqchip
> was already rejected for upstream[1] and the DT change would break
> working systems if the DTB is updated to a newer one. The latter issue
> was brought to my attention by Alex Graf.
>
> The root cause however is a bug in the shared handler. A shared handler
> must correctly identify it actually handled an interrupt. The handler
> here was processing data whether interrupts were enabled or not.
> It would return IRQ_HANDLED if there was any data and not only when
> there was an actual interrupt pending. The result is that another
> device's IRQ could cause the SPI's IRQ handler to run and process data
> when the the SPI driver working in polled mode. Fix this by adding a
> check in the IRQ handler that the TXEMPTY or IDLE interrupts are enabled
> and always return IRQ_NONE when they are not.

FWIW, I see v1 already applied in -next.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsO90sACgkQtdYpNtH8
nugLKg/+PtK1VrngCpRjwuNMo+X/9DDnuzRyT/OKhNII98FxMkagIrrq0KYYfZri
y1+WV6jxaHXGvPbgasheCr8+VjQQXEZXxzfk4eKvr4ixpuS1mcEGXwRX7YcL/bb8
f7/dL9Y9EG7Y2t85PXNySenLDvYdGBeNE5tmv15OOp3i0Tz+Syv1RwjtM6f+LMev
NnaTIFCIqxkNL0EJOdWSo0vpQyk3sgalp1FA+vHwe9SMcdCgj3MWtK+I2OtDJw7J
DTofk1gRishHzBan6lB6tBnMnZIU06Ag9Gx3T8jTYxzjUKoDet3VUbgzfQzaY8dU
MnnaRxIWFyap5ELBjnpVPgnoe1ZnBDZMpcCNJvH5RxGXp96dm6mBx9rJ9Bg7t7Pz
CczvNBzAnoCgOhCdjX2rd9AE+h0kN8MnvN217N6tAJB0Vu5OHIe6o0LKC1NMKIJr
Dblih8A1G20QfTwDf94lNtEGtupSDYS3qFdqCs+XfwwR1WGrQFPbcfR+PQKF0eum
YXoOxXnOwOcsE0yH+L5epzTO/+mtQ7Nl/HkWBgoyHnJheGedbojH3VI0AwlhGXKp
YYvDsrI+TvbLYZ8Nr5QUevRSRh2kVD9oomnguS//6LD+q7NDQ6iSHTQgxZ83qqrP
XYlClnoKy51pd3RX3jUjpHjb3QEWwcsxVXN8PichT0uIsS4UIHg=
=VbeI
-----END PGP SIGNATURE-----
--=-=-=--


--===============3168259045591088498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3168259045591088498==--
