From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC/PATCHv2 2/3] dt-binding: spi: spi-dw: Select 16b or 32b
 access for Designware SPI
Date: Sat, 7 Mar 2015 21:58:22 +0200
Message-ID: <CAHp75Vddg3T4oymsixbJWPWnELF3fE5Z4HRe4CxAFd+Eb=VVmA@mail.gmail.com>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
	<1425685594-26595-3-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Jiri Kosina <jkosina@suse.cz>, Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	ijc+devicetree@hellion.org.uk, dinguyen@opensource.altera.com,
	Linux Documentation List <linux-doc@vger.kernel.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	tthayer.linux@gmail.com, Axel Lin <axel.lin@ingics.com>,
	baruch@tkos.co.il,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kumar Gala <galak@codeaurora.org>
To: tthayer@opensource.altera.com
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1425685594-26595-3-git-send-email-tthayer@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Mar 7, 2015 at 1:46 AM,  <tthayer@opensource.altera.com> wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
>
> Altera's Arria10 architecture requires a 32bit write accesses for
> APB peripherals. The current spi-dw driver uses 16bit accesses in
> some locations. This patch updated the bindings with an optional
> field in the devicetree to select 32bit accesses.
>

One comment below.

> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-dw.txt |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-dw.txt b/Docum=
entation/devicetree/bindings/spi/spi-dw.txt
> index 7b63ed6..034dbdd 100644
> --- a/Documentation/devicetree/bindings/spi/spi-dw.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-dw.txt
> @@ -11,6 +11,7 @@ Required properties:
>
>  Optional properties:
>  - cs-gpios: see spi-bus.txt
> +- 32bit_access : use 32 bit register accesses
>

The most big issue for my opinion with DT is an absence of the
standard for naming properties.

So, why underscore? May be it's a time to append a generic description
of this field to Documentation/devicetree/=E2=80=A6


--=20
With Best Regards,
Andy Shevchenko
