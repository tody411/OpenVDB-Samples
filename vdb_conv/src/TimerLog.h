
/*!
  \file     TimerLog.h
  \author   Tody
  TimerLog definition.
  \date     2015/08/07
*/

#ifndef TIMERLOG_H
#define TIMERLOG_H

#include <iostream>
#include <iomanip>
#include <boost/timer.hpp>

//! TimerLog implementation.
class TimerLog : public boost::timer
{
public:
    void operator() ( const char* title )
    {
        std::cout << std::setw ( 20 ) << std::left << title;
        std::cout << ": " << elapsed() << " sec" << std::endl;
        restart();
    }

};

#endif

