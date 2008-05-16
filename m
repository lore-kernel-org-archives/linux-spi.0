From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/4] [CSB] Add new mpc5200-spi (non-psc) device driver
Date: Fri, 16 May 2008 13:42:39 -0600
Message-ID: <fa686aa40805161242g4295da76sdbebbc1009f041e4@mail.gmail.com>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	 <20080516193618.28030.15219.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755374AbYEPTmv@vger.kernel.org>
In-Reply-To: <20080516193618.28030.15219.stgit@trillian.secretlab.ca>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 16, 2008 at 1:36 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Unlike the old CSB driver, this driver uses the SPI infrastructure.

er, this comment is *obviously* wrong.  I'll fix it in the next version.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
