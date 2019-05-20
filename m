From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
Date: Mon, 20 May 2019 18:04:40 -0500
Message-ID: <CAL_JsqJ+GAgJuQy85bw1WoXCkpaqRY+V9G9HY8PUM3MGXqLyoQ@mail.gmail.com>
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
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
In-Reply-To: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
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

On Mon, May 20, 2019 at 9:50 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The SPI controllers have a bunch of generic options that are needed in a
> device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v2:
>   - Change the nodename pattern
>   - Add a note to mention that the binding has moved
>
> Changes from v1:
>   - Rework the nodename pattern
>   - Limit the index of the usable chip selects to 256
>   - Rework the slave devices regex
>   - Remove the requirement on #address-cells and #size-cells
>   - Declare the slave and slave devices nodes as objects
>   - Add spi-max-frequency
>   - Fix the bus width range
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt         | 112 +-----
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 161 +++++++-
>  2 files changed, 162 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-controller.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
