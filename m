From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
Date: Mon, 11 Jul 2011 15:35:25 +0800
Message-ID: <20110711073523.GA19105@S2100-06.ap.freescale.net>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
	<19994.41750.920408.162356@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: patches@linaro.org, devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	spi-devel-general@lists.sourceforge.net, Shawn Guo <shawn.guo@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <19994.41750.920408.162356@ipc1.ka-ro>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jul 11, 2011 at 09:15:34AM +0200, Lothar Wa=DFmann wrote:
> Hi,
> =

> Shawn Guo writes:
> > spi_imx_devtype_data has already been driver private data.  There is
> > really no need to make a copy in spi_imx_data.  Instead, a reference
> > pointer works perfectly fine.
> > =

> You obviously overlooked, that the copy is done on purpose to keep
> only the data that is actually needed and discard everything else
> after initialisation.
> =

I did not overlook that, as I removed __devinitdata there.

-- =

Regards,
Shawn
