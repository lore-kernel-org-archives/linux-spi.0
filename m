From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: spi: sun4i: Add YAML schemas
Date: Mon, 20 May 2019 18:06:15 -0500
Message-ID: <CAL_JsqJaNDZHyh7DFu1YO7OBE3wsTfgDALxx1cp_1E0Beue7Tg@mail.gmail.com>
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
 <b83d0e208072a4f7d017650bc10de8cbe7558a99.1558363790.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-spi <linux-spi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b83d0e208072a4f7d017650bc10de8cbe7558a99.1558363790.git-series.maxime.ripard@bootlin.com>
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

On Mon, May 20, 2019 at 9:51 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - Fix the slave device regex
> ---
>  Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/spi/spi-sun4i.txt                | 23 +-------------------
>  2 files changed, 86 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun4i.txt

Reviewed-by: Rob Herring <robh@kernel.org>
