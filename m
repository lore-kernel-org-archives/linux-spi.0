From: Marc Reilly <marc@cpdesign.com.au>
Subject: Re: mc13xxx-core, support for i2c, V4
Date: Sat, 12 Feb 2011 21:11:30 +1100
Message-ID: <201102122111.30525.marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
	<20110212084035.GB17755@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
To: Grant Likely <grant.likely@secretlab.ca>, sameo@linux.intel.com
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110212084035.GB17755@angua.secretlab.ca>
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

Hi Grant, 

Thanks for your comments,

On Saturday, February 12, 2011 07:40:35 pm Grant Likely wrote:
> On Tue, Jan 04, 2011 at 04:34:55PM +1100, Marc Reilly wrote:
> > Hi,
> > 
> > These patches add i2c support for the mc13xxx-core drive. For v4 I've
> > tried to take in all previous comments, hopefully making it better to
> > follow, and bisectable.
> 
> This series looks okay to me.  Since this is audio drivers, I expect
> that it would best be taken via the ASoC tree?  Have you sent it to
> Mark Brown and the ALSA list for review?
> 
> g.

Actually only the mc13873 has audio support. I think these IC's really fit 
better under the MFD tree, but silly me didn't add Samuel Ortiz (MFD 
maintainer) to this series... so included him now.

Samuel, are you the most appropriate to take this series in and would you like 
me to resend these patches to you? The thread archive is at [1]. 

Cheers
Marc

[1] 
http://lists.arm.linux.org.uk/lurker/message/20110104.053455.45bc5880.en.html
