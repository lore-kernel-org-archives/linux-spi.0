From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH v2] dmaengine: bcm2835: Add slave dma support
Date: Mon, 4 May 2015 08:59:09 +0200
Message-ID: <CF363C6E-B277-4CF0-BB99-19A5C2F1A9CD@martin.sperl.org>
References: <1429355160-13657-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dmaengine@vger.kernel.org, vinod.koul@intel.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jonathan@raspberrypi.org,
	linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
	dan.j.williams@intel.com, linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
To: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429355160-13657-1-git-send-email-noralf@tronnes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I did tests with the (almost) finished dma-support of spi-bcm2835
against a TFT device and it work fine there.

Upstreaming this spi-bcm2835 patch obviously requires that the DMA
support is in the dma-engine driver first...

Please also see prior note about unnecessary interrupts when none
are requested for possible improvements.

> On 18.04.2015, at 13:06, Noralf Tr=C3=B8nnes <noralf@tronnes.org> wro=
te:
>=20
> Add slave transfer capability to BCM2835 dmaengine driver.
> This patch is pulled from the bcm2708-dmaengine driver in the
> Raspberry Pi repo. The work was done by Gellert Weisz.
>=20
> Tested using the bcm2835-mmc driver from the same repo.
>=20
> Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>

Tested-by: Martin Sperl <kernel@martin.sperl.org>
