From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx
	driver
Date: Thu, 2 Sep 2010 10:27:59 +0200
Message-ID: <20100902082759.GE14214@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	s.hauer@pengutronix.de, amit.kucheria@canonical.com,
	linux-arm-kernel@lists.infradead.org
To: Jason Wang <jason77.wang@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
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

Hello Jason,

On Thu, Sep 02, 2010 at 03:51:58PM +0800, Jason Wang wrote:
> Some explanations:
> =

> This patchset is to add SPI support in the existing spi_imx driver for
> i.MX51 and add SPI relating stuffs for mx51_3ds board level.
> =

> i.MX51 has two eCSPI controllers and one CSPI controller, CSPI
> controller is 100% compatible with the one of i.MX35, so we don't need
> to add new functions for this CSPI, only bind it with i.MX35 together,
> while eCSPI isn't compatible with existing controllers of i.MX
> platforms, so i add new functions for these two eCSPIs in the existing
> spi_imx driver.
> =

> If these patches pass review, the first patch 0001-xxx.patch should be
> merged by Grant.likely; other patches(0002-0006) are based off
> imx-for-2.6.37 and should be handled by Sascha.

Unfortunately we (=3DPengutronix) have some patches pending to add
mx51-spi support, too.  And there are some other patches that will
conflict with your series (e.g. I renamed some symbols used by you:

-#define MX51_CSPI1_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x10000)
+#define MX51_ECSPI1_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x10000)
-#define MX51_CSPI2_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xac000)
+#define MX51_ECSPI2_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xac000)
-#define MX51_CSPI3_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xc0000)
+#define MX51_CSPI_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xc0000)
-#define MX51_MXC_INT_CSPI1		36
-#define MX51_MXC_INT_CSPI2		37
-#define MX51_MXC_INT_CSPI		38
+#define MX51_INT_ECSPI1			36
+#define MX51_INT_ECSPI2			37
+#define MX51_INT_CSPI			38
)

Actually I would prefer our patches, but of course I'm biased :-)

I don't know how we should handle this.  And Sascha is on vacation this
and next week.  I will investigate if our patches are already free to be
posted.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
