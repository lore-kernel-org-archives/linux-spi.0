From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [QUERY] amba/pl022: DMA channel allocation always fail.
Date: Fri, 13 May 2011 16:31:04 +0200
Message-ID: <BANLkTinMH9TpTTzqoMPS7JZUBRss3pScWg@mail.gmail.com>
References: <4DCD1D80.7060409@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Armando VISCONTI <armando.visconti@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	viresh kumar <viresh.linux@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: viresh kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4DCD1D80.7060409@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

2011/5/13 viresh kumar <viresh.kumar@st.com>:

> amba/pl022 and my dma driver dw_dmac.c, both have registered init() routines
> with subsys_initcall(). Now at bootup, spi boots up before DMA and so DMA
> channels are never available at spi probe.
>
> What should be done to solve this issue?

If you check drivers/dma/ste_dma40.c you can see that our solution was to
simply move the DMA engine to arch_initcall().

Which sort of makes sense for a DMA engine.

Does this work for dw_dmac.c?

> One idea is allocate DMA channel as and when required, instead of allocating them
> at probe. But in that case too i am not sure, that this issue will be solved.

For the serial port I've added a real funny tweak to queue the ports
and add DMA later since these are initialized very early.

Check in drivers/tty/serial/amba-pl011.c

Hope this helps,
Linus Walleij
