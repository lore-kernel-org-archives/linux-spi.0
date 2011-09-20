From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2 0/6] spi/spi-pl022 fixes
Date: Tue, 20 Sep 2011 11:23:59 -0600
Message-ID: <20110920172359.GB7781@ponder.secretlab.ca>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<4E5F58BB.4020205@st.com>
	<CACRpkdYeq9in+U_tyvb=yVuX2t5TnkUSsO+BozUGVJwZVh+4Ag@mail.gmail.com>
	<4E78761C.9030908@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Pratyush ANAND <pratyush.anand@st.com>,
	Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Bhavna YADAV <bhavna.yadav@st.com>,
	Bhupesh SHARMA <bhupesh.sharma@st.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	Vipin KUMAR <vipin.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>,
	Amit VIRDI <Amit.VIRDI@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	Deepak SIKRI <deepak.sikri@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Viresh Kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E78761C.9030908@st.com>
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

On Tue, Sep 20, 2011 at 04:46:44PM +0530, Viresh Kumar wrote:
> On 9/1/2011 4:26 PM, Linus Walleij wrote:
> > I agree. Acked-by: Linus Walleij <linus.walleij@linaro.org> for
> > all except 6/6, it's probably just as possible to keep the channel handle
> > taken in the driver if we modify the affected DMA driver instead.
> > This would be better for performance I think.
> 
> Hi Grant,
> 
> Any updates on this?

Applied 1-5, thanks.

g.

> 
> -- 
> viresh
