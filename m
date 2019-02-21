From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] spi: spi-gpio: fix SPI_CS_HIGH capability
Date: Thu, 21 Feb 2019 13:14:04 -0300
Message-ID: <CAOMZO5B_ELinMtAipaM9GP3Frj1YxRA5DmL-RJYnSE5i_W04uw@mail.gmail.com>
References: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
 <E1gwqlS-00053l-QU@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Mark Brown <broonie@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-spi@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1gwqlS-00053l-QU@rmk-PC.armlinux.org.uk>
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

On Thu, Feb 21, 2019 at 1:00 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
>
> spi-gpio is capable of dealing with active-high chip-selects.
> Unfortunately, commit 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE
> support") broke this by setting master->mode_bits, which overrides
> the setting in the spi-bitbang code.  Fix this.
>
> Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Patch against 4.20

Adding Jonathan who sent a similar fix recently:
https://patchwork.kernel.org/patch/10804855/
