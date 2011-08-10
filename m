From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2 3/6] spi/spi-pl022: Don't allocate more sg
	than	required.
Date: Wed, 10 Aug 2011 14:35:54 +0530
Message-ID: <4E4249F2.1020406@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<94a975df64a78bb533c85774a5bbd052c73fa5ba.1312965741.git.viresh.kumar@st.com>
	<20110810085431.GD1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Pratyush ANAND <pratyush.anand@st.com>,
	Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Bhavna YADAV <bhavna.yadav@st.com>,
	Bhupesh SHARMA <bhupesh.sharma@st.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	Vipin KUMAR <vipin.kumar@st.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <Amit.VIRDI@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	Deepak SIKRI <deepak.sikri@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110810085431.GD1831@n2100.arm.linux.org.uk>
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

On 08/10/2011 02:24 PM, Russell King - ARM Linux wrote:
> It would be far better for this to be:
> 
> 	pages = DIV_ROUND_UP(pl022->cur_transfer->len, PAGE_SIZE);
> 
> The compiler will probably optimize it to the same code anyway.

I thought of it too, but missed to update code. Thanks.

-- 
viresh
