From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: spi/spi-pl022: Query on working of DMA mode
Date: Thu, 4 Aug 2011 12:16:44 +0200
Message-ID: <CACRpkdZW2tj=JdfqFzif_bPt0UJ8wOmsMuOeBhSjH4+qUA3pSA@mail.gmail.com>
References: <4E3931B7.3010400@st.com>
	<CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>
	<4E3A147B.9060305@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	viresh kumar <viresh.linux@gmail.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: viresh kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E3A147B.9060305@st.com>
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

On Thu, Aug 4, 2011 at 5:39 AM, viresh kumar <viresh.kumar@st.com> wrote:

>>> > Is DMA mode working in your case?
>> Yes, magically :-/
>
> But how? Don't you have any message with more than one transfer in it?

No maybe not, my test cases are for single messages, and on production
systems we mainly use IRQ-driven traffic. I need to have these
tests added I believe :-/

If you fix this up it will be much appreciated!

Thanks,
Linus Walleij
