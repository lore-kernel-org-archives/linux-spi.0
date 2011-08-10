From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH 4/6] spi/spi-pl022: calculate_effective_freq() must set
	rate <= requested rate
Date: Wed, 10 Aug 2011 09:06:43 +0530
Message-ID: <4E41FCCB.7040609@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>	<abd4dbaedf226ad29461775bcd969810c87c305d.1312887860.git.viresh.kumar@st.com>
	<CACRpkdYAkPtOkVuF-UhpFHugvZpw_owmgoxP_opF8KE=cYF95w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipin KUMAR <vipin.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>,
	Bhavna YADAV <bhavna.yadav@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Armando VISCONTI <armando.visconti@st.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <amit.virdi@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	viresh kumar <viresh.linux@gmail.com>, deepak sikri <deepak.sikri@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdYAkPtOkVuF-UhpFHugvZpw_owmgoxP_opF8KE=cYF95w@mail.gmail.com>
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

[Probably you missed reply-all by mistake, so adding them again]

On 08/10/2011 01:34 AM, Linus Walleij wrote:
> On Tue, Aug 9, 2011 at 1:05 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> 
>> There were few issues with calculate_effective_freq() routine:
>> - It was returning first rate found >= requested rate. Now, if system have spi's
>>  rate as 83 MHz, with possible prescaled rates as 83, 41.5, 20.75, 13.83 (as we
>>  can prescale with multiples of 2). If user has given rate to be programmed as
>>  22 MHz, then driver programmes it to 41.5 MHz. This looks to be incorrect, as
>>  user might have given the upper limit of the device, and we are programming it
>>  above it.
>> - Driver finds the first satisfying rate and programmes it, but with other
>>  values of scr & cpsdvsr, it is possible to get more closer rate.
> 
> Good that you found this bug!
> 
>> +#define SPI_RATE(rate, cpsdvsr, scr)   (rate / (cpsdvsr * (1 + scr)))
> 
> Can you use a static inline instead of a macro? It is often preferred.
> If you do, this is Acked-by.
> 

Not a problem. Will surely do that.

-- 
viresh
