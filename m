From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7 1/3] acpi: Rename acpi_gsi_get_irq_type to
 acpi_dev_get_irq_type and export symbol
Date: Fri, 18 Dec 2015 10:40:50 +0200
Message-ID: <20151218084050.GC1762@lahna.fi.intel.com>
References: <1450163493-4938-1-git-send-email-christophe-h.ricard@st.com>
 <1450163493-4938-2-git-send-email-christophe-h.ricard@st.com>
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
In-Reply-To: <1450163493-4938-2-git-send-email-christophe-h.ricard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 15, 2015 at 08:11:31AM +0100, Christophe Ricard wrote:
> acpi_gsi_get_irq_type could be use out of gsi purpose.
> 
> Rename and make it available as a resource function.
> 
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
