From: viresh kumar <viresh.kumar@st.com>
Subject: Re: spi/spi-pl022: Query on working of DMA mode
Date: Thu, 4 Aug 2011 09:09:39 +0530
Message-ID: <4E3A147B.9060305@st.com>
References: <4E3931B7.3010400@st.com>
	<CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>
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
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>
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

On 08/03/2011 08:28 PM, Linus Walleij wrote:
>> > Here, allocation is requested with GFP_KERNEL flag, from a tasklet.
>> > Which gives following crash logs:
> What happens if you replace it with GFP_NOWAIT?
> 
> That should work for everybody.
> 
> Or you could remove the tasklet allover and replace it with a workqueue.
> 

Ok. I will fix this and include in my patchset.

>> > Is DMA mode working in your case?
> Yes, magically :-/

But how? Don't you have any message with more than one transfer in it?

-- 
viresh
