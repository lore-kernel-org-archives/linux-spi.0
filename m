From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/3] acpi: Rename acpi_gsi_get_irq_type to
 acpi_get_irq_type and export symbol
Date: Wed, 9 Dec 2015 15:36:46 +0200
Message-ID: <20151209133646.GV1766@lahna.fi.intel.com>
References: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
 <1449527952-8399-2-git-send-email-christophe-h.ricard@st.com>
 <20151208112855.GI1766@lahna.fi.intel.com>
 <5667523F.60704@gmail.com>
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
In-Reply-To: <5667523F.60704@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 08, 2015 at 10:57:19PM +0100, Christophe Ricard wrote:
> I believe changes done in this patch take benefit of another existing
> function used in acpi gsi context that is doing the
> job as expected.
> 
> Do you still believe acpi_dev_irq_flags is more appropriate ?

I don't have strong feelings about that. I just wanted to point out
there already exists such function.

However, if you do use acpi_gsi_get_irq_type() I think it should be
placed to the same file as acpi_dev_irq_flags().
