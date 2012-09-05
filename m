From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi/pl022: Fix chipselects pointer computation
Date: Thu, 6 Sep 2012 07:44:33 +0800
Message-ID: <20120905234432.GI10580@opensource.wolfsonmicro.com>
References: <1346660069-16049-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linus.walleij@linaro.org, shiraz.linux.kernel@gmail.com,
	aletes.xgr@gmail.com, grant.likely@secretlab.ca,
	rob.herring@calxeda.com, rob@landley.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	gabriel.fernandez@stericsson.com, lee.jones@linaro.org,
	viresh.kumar@linaro.org, sachin.verma@st.co
To: Roland Stigge <stigge@antcom.de>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346660069-16049-1-git-send-email-stigge@antcom.de>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 03, 2012 at 10:14:29AM +0200, Roland Stigge wrote:
> The new chip select handling via GPIO introduced a pointer computation bug:

Applied, thanks.
