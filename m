From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
Date: Fri, 19 Aug 2016 21:05:04 +0900 (JST)
Message-ID: <20160819.210504.65713466261092409.anemo@mba.ocn.ne.jp>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
        <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: ralf@linux-mips.org, broonie@kernel.org, wim@iguana.be,
        linux@roeck-us.net, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
To: geert@linux-m68k.org
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org

On Thu, 18 Aug 2016 19:34:27 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Replace the custom minimal clock implementation for Toshiba TXx9 by a
> basic implementation using the Common Clock Framework.

Thank you for good cleanup.

> +	if (TX4938_REV_PCODE() == 0x4938) {
> +		clk = clk_register_fixed_factor(NULL, "spi", "gbus", 0, 1, 4);
> +		error = clk_register_clkdev(clk, "spi-baseclk", NULL);
> +		if (error)
> +			goto fail;
> +	}

Unfortunately, TX4938_REV_PCODE() can be used only on TX49 based
platforms.  Please enclose this block with #ifdef CONFIG_CPU_TX49XX.

Or, while registering unused clkdev will not bloat kernel so much,
just remove this TX4938 checking.

---
Atsushi Nemoto
