From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/3] acpi: Rename acpi_gsi_get_irq_type to
 acpi_get_irq_type and export symbol
Date: Tue, 8 Dec 2015 13:28:55 +0200
Message-ID: <20151208112855.GI1766@lahna.fi.intel.com>
References: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
 <1449527952-8399-2-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org,
	gnurou@gmail.com, andriy.shevchenko@linux.intel.com,
	broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Christophe Ricard <christophe-h.ricard@st.com>
To: Christophe Ricard <christophe.ricard@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449527952-8399-2-git-send-email-christophe-h.ricard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 07, 2015 at 11:39:10PM +0100, Christophe Ricard wrote:
> acpi_gsi_get_irq_type could be use out of gsi purpose.
> 
> Rename and make it available as a utility function.
> 
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>

There is already a function acpi_dev_irq_flags() converts ACPI flags to
Linux resource IRQ flags. Any reason you are not using that?
