From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Fri, 19 Aug 2011 19:19:04 +0530
Message-ID: <1313761744.18591.5.camel@vkoul-udesk3>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
	<20110810104025.GK1831@n2100.arm.linux.org.uk>
	<CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
	<CACRpkdaCyUJ3A9VWfsVuwJj3DGVkvjc2_ZOD4yM4YX3NPxAAYQ@mail.gmail.com>
	<CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
	<1313009883.1603.25.camel@vkoul-udesk3>
	<CABb+yY0Hy9DcHf+D0OrrGjxkR=V8sa4Q-Kvd1iH01oChnoEE6w@mail.gmail.com>
	<1313495727.1603.83.camel@vkoul-udesk3>
	<CABb+yY3gdkDZf7vZGV1Bcdyo0VphnA2odk8nRy3aCcv9kxjGXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "pratyush.anand@st.com" <pratyush.anand@st.com>,
	"rajeev-dlh.kumar@st.com" <rajeev-dlh.kumar@st.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"bhupesh.sharma@st.com" <bhupesh.sharma@st.com>,
	"armando.visconti@st.com" <armando.visconti@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"vipin.kumar@st.com" <vipin.kumar@st.com>,
	"shiraz.hashim@st.com" <shiraz.hashim@st.com>,
	"Amit.VIRDI@st.com" <Amit.VIRDI@st.com>,
	"vipulkumar.samar@st.com" <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"deepak.sikri@st.com" <deepak.sikri@st.com>,
	"bhavna.yadav@st.com" <bhavna.yadav@st.com>, "Williams,
	Dan J" <dan.j.williams@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infrad
To: Jassi Brar <jassisinghbrar@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABb+yY3gdkDZf7vZGV1Bcdyo0VphnA2odk8nRy3aCcv9kxjGXQ@mail.gmail.com>
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

On Tue, 2011-08-16 at 20:21 +0530, Jassi Brar wrote:
> On Tue, Aug 16, 2011 at 5:25 PM, Koul, Vinod <vinod.koul@intel.com> wrote:

> 
> > Sorry I still don't get this schema and how it can be scaled and be
> > generic enough to let it carry with various implementations.
> >
> > Can you publish your complete idea rather than bits and pieces...
> I already explained the complete idea. I don't have any implementation yet.
> Clients and dmaengine.c is easier to manage.
> But changes to >20 dmac drivers is the biggest effort - though they anyway
> need such modifications if we are to have the DMAENGINE utopia someday.
> In free time, I will modify a dmac driver or two, but it might take
> prohibitively
> long if I am expected to update possibly all the 20 dmac drivers and the backend
> platforms by
It would help if you can send RFC of changes in one driver and dmaengine
changes. I want to get the dmaengine changes understood well and be able
to deal with all scenarios we have. Without complete code its rather
hard :(
We can do these changes to other drivers over a period of time, that can
be taken over a period of time and we can manage that, this part is
easy.
>   a) Making dmac drivers platform agnostic and for re-routable ReqSig-Peri map.
>        That implies dmac drivers managing 'virtual-channel' front end
> and physical
>        channel and ReqSig->Peri link management in the backend with
> help from platform.
>   b) Modifying platforms/boards to pass channel map and link re-routing callback
>       pointers to generic dmac drivers.


-- 
~Vinod
