From: Federico Vaga <federico.vaga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] spidev.c: add sysfs attributes for SPI configuration
Date: Sat, 22 Dec 2012 12:21:15 +0100
Message-ID: <4348691.tj7B63aR8x@number-5>
References: <1353777608-24934-1-git-send-email-federico.vaga@gmail.com>
	<1440955.3UsNh3CGzX@number-5>
	<20121222094725.797F03E03CE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121222094725.797F03E03CE@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> I'm cautious about adding operational interfaces to sysfs because it
> can be quite difficult to get the locking right. To begin with it
> splits up a single interface into multiple files, any of which can
> be held open by a process. Then there is the question of ordering
> of operations when there are multiple users. For instance, if there
> were two users, each of which using different transfer parameters,
> a sysfs interface doesn't provide any mechanism to group setting up
> the device with the transfer.
> 
> These are lessons learned the hard way with the gpio sysfs abi. I
> don't want to get caught in the same trap for spi.
> 
> g.

I understand the problem, but I think that for very simple test on 
devices, sysfs is easier. For example, it happens that a SPI device 
does not work correctly with a driver, so I want to verify the SPI 
traffic by writing directly the device commands and check with an 
oscilloscope. I think that an easy way is to use sysfs like this:

echo 123456 > speed_hz
[other options if needed]
echo  -n -e "\x12\x34" > /dev/spidev1.1
[oscilloscope]
hexdump -n 2 /dev/spidev1.1

This sysfs interface should be used only for testing/debugging, not to 
develop an user space driver on it; moreover, the ioctl interface is 
still there.

spidev_test and spidev_fdx does not allow me to customize tx buffer and 
I think (very personal opinion) that for debugging purpose is better 
sysfs with well known programs (echo, cat, hexdump, od) and 
oscilloscope. 

I know that I'm not so persuasive :) I can develop a simple program 
that can write custom tx buf with ioctl

-- 
Federico Vaga

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
