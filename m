From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
Date: Fri, 10 May 2019 11:05:48 -0500
Message-ID: <CAL_JsqLRWSWk7cV=pYi1fbYsLJFUxE1fMo6Bm2FC99oPtS-88w@mail.gmail.com>
References: <1acc9ff7f59064b74cc319b7812479bcd842a897.1557386749.git-series.maxime.ripard@bootlin.com>
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
In-Reply-To: <1acc9ff7f59064b74cc319b7812479bcd842a897.1557386749.git-series.maxime.ripard@bootlin.com>
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

On Thu, May 9, 2019 at 2:26 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The SPI controllers have a bunch of generic options that are needed in a
> device tree. Add a YAML schemas for those.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
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
>  Documentation/devicetree/bindings/spi/spi-bus.txt         | 111 +-----
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 161 +++++++-
>  2 files changed, 161 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-bus.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-controller.yaml


> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> new file mode 100644
> index 000000000000..6258644249b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI Controller Generic Binding
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>
> +
> +description: |
> +  SPI busses can be described with a node for the SPI controller device
> +  and a set of child nodes for each SPI slave on the bus. The system SPI
> +  controller may be described for use in SPI master mode or in SPI slave mode,
> +  but not for both at the same time.
> +
> +properties:
> +  $nodename:
> +    pattern: "^spi(@.*)$"

Doing some testing with spi-gpio schema I'm writing, this needs to be
"^spi(@.*)*$" so that just 'spi' is allowed. However, that's not
enough for handling multiple instances of spi-gpio. So maybe we need
"^spi(@.*|-[0-9a-f])*$" to allow spi-1, spi-2, etc. Really, we need to
decide the larger issue of how we handle multiple instances when
there's no address space.

Also, this schema will be applied to any matching node name as it is
used for automatic selection if compatible schema is not present. If
we want to prevent that and only apply it when explicitly included,
then we need to add a 'select: false'. Without it, we get more
coverage, but it could slow things down and we'll get double printing
of errors.

Rob
