From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from
 driver data struct
Date: Fri, 30 Nov 2018 19:21:00 +0100
Message-ID: <20181130182100.rdr3umwgonnqx44v@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
 <1543598496.18519.101.camel@impinj.com>
 <20181130175004.iiduvgzwwij3fvof@pengutronix.de>
 <1543601425.18519.108.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "marex@denx.de" <marex@denx.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1543601425.18519.108.camel@impinj.com>
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

Hello,

On Fri, Nov 30, 2018 at 06:10:26PM +0000, Trent Piepho wrote:
> [1] Confusingly, imx23 and imx28 are totally different chips that other
> imx chips, like imx21 and imx27.  The former are "mxs" designs that
> Freescale bought from someone else (I think ST-Micro?).

FTR: the mxs family includes parts that were bought by Freescale from
Sigmatel.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
