From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v8 3/3] ACPI / spi: attach gpio irq from acpi description
 to spi device
Date: Mon, 28 Dec 2015 13:36:28 +0200
Message-ID: <20151228113628.GS1758@lahna.fi.intel.com>
References: <1450909535-32138-1-git-send-email-christophe-h.ricard@st.com>
 <1450909535-32138-4-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org,
	gnurou@gmail.com, andriy.shevchenko@linux.intel.com,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Christophe Ricard <christophe-h.ricard@st.com>
To: Christophe Ricard <christophe.ricard@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450909535-32138-4-git-send-email-christophe-h.ricard@st.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 23, 2015 at 11:25:35PM +0100, Christophe Ricard wrote:
> spi->irq was ignoring GpioInt property setting it to -1.
> acpi_dev_gpio_irq_get returns and configure the slave irq according to
> the acpi slave node description.
> It is now inline with devicetree behavior.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
