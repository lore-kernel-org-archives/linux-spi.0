From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
Date: Thu, 20 Dec 2018 16:50:49 +0100
Message-ID: <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
References: <20181216084854.GJ13243@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: frieder.schrempf@kontron.de, linux-spi <linux-spi@vger.kernel.org>,
 arm-soc <arm@kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Shawn Guo <shawnguo@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181216084854.GJ13243@dragon>
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

On Sun, Dec 16, 2018 at 9:50 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> Hi,
>
> As the series cleans up both i.MX/Freescale arm32 and arm64 device
> trees, the pull request is based on a merge of tag imx-dt-4.21 and
> imx-dt64-4.21 that have already been pulled into arm-soc next/dt branch.
> This comes a bit late, and we appreciate it if you can pull it for 4.21,
> as it paves the way for new QSPI driver under SPI framework to land in
> the next release cycle.  Thanks.

Pulled into next/dt. For my understanding, what is going to happen
with the fsl-quadspi mtd driver? Will it remain as part of the kernel
to support old DTB files, or will that transitions mean those stop
working with new kernels and have to be updated the same way?

Thanks,

      Arnd
