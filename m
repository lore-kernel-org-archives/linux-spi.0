From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/6] spi/spi-pl022 fixes
Date: Tue, 9 Aug 2011 22:10:35 +0200
Message-ID: <CACRpkdatTqnSMxKzhYo=EYpP21buN0tosx1Y1aVc7RLe58wfgg@mail.gmail.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: vipin.kumar@st.com, rajeev-dlh.kumar@st.com, bhavna.yadav@st.com,
	bhupesh.sharma@st.com, pratyush.anand@st.com,
	armando.visconti@st.com, grant.likely@secretlab.ca,
	shiraz.hashim@st.com, amit.virdi@st.com, vipulkumar.samar@st.com,
	viresh.linux@gmail.com, deepak.sikri@st.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Viresh Kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1312887860.git.viresh.kumar@st.com>
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

On Tue, Aug 9, 2011 at 1:05 PM, Viresh Kumar <viresh.kumar@st.com> wrote:

> This patchset mainly covers following fixes:
> - formatting related issues
> - Passing GFP_NOWAIT for sg allocation from tasklet
> - Fixing calculate_effective_freq() routine
> - Allocate/free DMA channels as and when required.

Excellent work Viresh, apart from the small comment on 4/6
they all look good.

I also tested them all on the U300, works perfectly.

Please fixup 4/6 and respin with my:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

So that Grant can pick them up.

> I have rebased them on linux-next/master over following patch:
>
> commit 9be355da3bae9feb09cdaf80c3ab560f1f0172cb
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: =A0 Tue Aug 9 13:30:19 2011 +1000
>
> =A0 =A0Add linux-next specific files for 20110809

They all work perfectly well on top of v3.1-rc1, please use
mainline kernel tags as patch base if you can.

Yours,
Linus Walleij
