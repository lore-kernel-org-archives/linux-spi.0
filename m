From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC] spidev.c: add sysfs attributes for SPI configuration
Date: Sat, 22 Dec 2012 10:29:09 -0800
Message-ID: <20121222182909.GA18767@kroah.com>
References: <1353777608-24934-1-git-send-email-federico.vaga@gmail.com>
 <1440955.3UsNh3CGzX@number-5>
 <20121222094725.797F03E03CE@localhost>
 <4348691.tj7B63aR8x@number-5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Federico Vaga <federico.vaga@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4348691.tj7B63aR8x@number-5>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Dec 22, 2012 at 12:21:15PM +0100, Federico Vaga wrote:
> > I'm cautious about adding operational interfaces to sysfs because it
> > can be quite difficult to get the locking right. To begin with it
> > splits up a single interface into multiple files, any of which can
> > be held open by a process. Then there is the question of ordering
> > of operations when there are multiple users. For instance, if there
> > were two users, each of which using different transfer parameters,
> > a sysfs interface doesn't provide any mechanism to group setting up
> > the device with the transfer.
> > 
> > These are lessons learned the hard way with the gpio sysfs abi. I
> > don't want to get caught in the same trap for spi.
> > 
> > g.
> 
> I understand the problem, but I think that for very simple test on 
> devices, sysfs is easier. For example, it happens that a SPI device 
> does not work correctly with a driver, so I want to verify the SPI 
> traffic by writing directly the device commands and check with an 
> oscilloscope. I think that an easy way is to use sysfs like this:
> 
> echo 123456 > speed_hz
> [other options if needed]
> echo  -n -e "\x12\x34" > /dev/spidev1.1
> [oscilloscope]
> hexdump -n 2 /dev/spidev1.1
> 
> This sysfs interface should be used only for testing/debugging, not to 
> develop an user space driver on it; moreover, the ioctl interface is 
> still there.

Then move it to debugfs, don't put debugging code in sysfs, as once you
do, you are stuck with it for life (hint, you forgot to add
Documentation/ABI entries for your new sysfs files, which are required).

If you move this to debugfs, you can do whatever you want, as it's
obvious no one would ever put "real" interfaces in debugfs :)

thanks,

greg k-h
