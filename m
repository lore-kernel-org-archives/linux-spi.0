From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 1/3] spi/pl022: Add chip select handling via GPIO
Date: Wed, 22 Aug 2012 20:37:39 +0200
Message-ID: <CACRpkdYcF4ct0Y5wZm1YMSTFSHwoJJP9G6nax78D8G6esokO5Q@mail.gmail.com>
References: <1345643359-16584-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: aletes.xgr@gmail.com, broonie@opensource.wolfsonmicro.com,
	grant.likely@secretlab.ca, rob.herring@calxeda.com,
	rob@landley.net, devicetree-discuss@lists.ozlabs.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	gabriel.fernandez@stericsson.com, lee.jones@linaro.org,
	viresh.kumar@linaro.org, sachin.verma@st.co
To: Roland Stigge <stigge@antcom.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345643359-16584-1-git-send-email-stigge@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 22, 2012 at 3:49 PM, Roland Stigge <stigge@antcom.de> wrote:

> This patch adds the ability for the driver to control the chip select directly.
> This enables independence from cs_control callbacks.  Configurable via
> platform_data, to be extended as DT in the following patch.
>
> Based on the initial patch by Alexandre Pereira da Silva <aletes.xgr@gmail.com>
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Thanks Roland, excellent work!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
